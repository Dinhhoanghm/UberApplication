package rs.ac.uns.ftn.transport.specification;

import org.springframework.data.jpa.domain.Specification;
import rs.ac.uns.ftn.transport.model.WorkingHours;

import java.time.LocalDateTime;

public class WorkingHoursSpecification {
  public static Specification<WorkingHours> matchStartEndAndDriver(LocalDateTime start, LocalDateTime end, Integer driverId) {
    return (root, query, cb) -> cb.and(
      cb.equal(root.get("start"), start),
      cb.equal(root.get("end"), end),
      cb.equal(root.get("driver").get("id"), driverId)
    );
  }
}