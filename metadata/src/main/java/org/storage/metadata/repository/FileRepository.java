package org.storage.metadata.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.storage.metadata.model.File;

@Repository
public interface FileRepository extends JpaRepository<File, Long> {

}
