import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Location } from '../../shared/model/Location'; // Represents location data.
import { MapService } from '../../shared/map/map.service'; // Manages map-related operations.
import { DriverService } from '../driver.service'; // Handles actions related to the driver.
import { NotificationService } from '../../shared/notification-service/notification.service'; // Displays notifications to the user.

@Component({
  selector: 'app-driver-ride', // Component's HTML tag.
  templateUrl: './driver-ride.component.html', // Path to the component's HTML template.
  styleUrls: [
    '../../passenger/ride-estimates/ride-estimates.component.css',
    './driver-ride.component.css',
    '../../app.component.css',
  ], // Array of stylesheets used by the component.
})
export class DriverRideComponent implements OnInit {
  constructor(
    public mapService: MapService, // Injects the MapService to manage map functionality.
    private driverService: DriverService, // Injects the DriverService for driver-related operations.
    private notificationService: NotificationService // Injects the NotificationService for alert messages.
  ) {}

  // Form to capture departure and destination locations.
  searchForm: FormGroup = new FormGroup({
    departure: new FormControl('', { validators: [Validators.required] }), // Input for departure location.
    destination: new FormControl('', { validators: [Validators.required] }), // Input for destination location.
  });

  // Emitters to send events to parent components.
  @Output() chosenDeparture = new EventEmitter<Location>(); // Emits the selected departure location.
  @Output() chosenDestination = new EventEmitter<Location>(); // Emits the selected destination location.
  @Output() bothLocationsSelected = new EventEmitter<boolean>(); // Emits a signal when both locations are selected.

  rideInProgress = false; // Indicates whether a ride is currently active.

  // Lifecycle hook: Initializes the component.
  ngOnInit() {
    if (this.driverService.receivedRide) {
      const ride = this.driverService.currentRide; // Retrieve the current ride information.

      // Check if the logged-in driver is assigned to the ride.
      if (ride?.driver.id === parseInt(sessionStorage.getItem('user_id')!)) {
        this.searchForm.disable(); // Disable the form if the ride is assigned.
        this.searchForm.controls['departure'].setValue(ride?.locations[0].departure.address); // Set the departure address.
        this.searchForm.controls['destination'].setValue(ride?.locations[0].destination.address); // Set the destination address.

        // Update the map with the ride's details.
        this.mapService.setIsDriver(true);
        this.mapService.setDeparture(<Location>ride?.locations[0].departure);
        this.mapService.setDestination(<Location>ride?.locations[0].destination);
        this.bothLocationsSelected.emit(true); // Emit event indicating both locations are selected.
      }
    } else {
      // Default fallback if no ride is assigned.
      this.searchForm.disable(); // Disable the form.
      this.searchForm.controls['departure'].setValue('Default departure address'); // Set a default departure address.
      this.searchForm.controls['destination'].setValue('Default destination address'); // Set a default destination address.

      // Set default locations on the map.
      this.mapService.setIsDriver(true);
      this.mapService.setDeparture(new Location('Default departure location', 19.850956, 45.245972));
      this.mapService.setDestination(new Location('Default destination location', 19.833455, 45.246703));

      this.bothLocationsSelected.emit(true); // Emit event indicating both locations are set.

      // Subscribe to ride progress updates.
      this.mapService.rideInProgress$.subscribe((rideInProgress) => {
        this.rideInProgress = rideInProgress;
      });
    }
  }

  // Triggers when the user selects valid locations.
  public drawRoute(): void {
    if (this.searchForm.valid) {
      this.bothLocationsSelected.emit(true); // Emit event indicating locations are valid.
    }
  }

  // Accepts and starts a ride.
  public accept(): void {
    if (!this.driverService.rideToDepartureDone) {
      this.notificationService.createNotification('You must first reach the starting point to begin the ride.', 2000);
      return;
    }

    // Accept and start the ride.
    this.driverService.acceptRide().subscribe({
      next: () => {
        this.driverService.startRide().subscribe({
          next: () => {
            this.mapService.setRideInProgress(true); // Mark the ride as in progress.
            this.chosenDeparture.emit(this.driverService.currentRide?.locations[0].departure);
            this.chosenDestination.emit(this.driverService.currentRide?.locations[0].destination);
            this.bothLocationsSelected.emit(true);
            this.mapService.simulateMovementToDestination = true; // Simulate movement on the map.
            this.mapService.setSimulateToDestination(true);
            this.driverService.rideToDepartureDone = false; // Reset departure status.
          },
          error: (error) => {
            console.error(error.error.message); // Log any errors.
          },
        });
      },
      error: (error) => {
        console.error(error.error.message); // Log any errors.
      },
    });
  }

  // Denies a ride.
  public deny(): void {
    this.mapService.setRideDenied(true); // Mark the ride as denied.
  }

  // Completes a ride.
  public finish(): void {
    if (!this.driverService.rideToDestinationDone) {
      this.notificationService.createNotification('You must first reach the destination to complete the ride.', 2000);
      return;
    }

    // End the ride and refresh the UI.
    this.driverService.endRide().subscribe({
      next: () => {
        this.mapService.setRideInProgress(false); // Mark the ride as complete.
        this.mapService.setRideReceived(false); // Reset ride status.

        setTimeout(() => {
          window.location.reload(); // Refresh the page to reset the UI.
        }, 250);
      },
      error: (error) => {
        console.error(error.error.message); // Log any errors.
      },
    });
  }
}
