package org.storage.metadata.service;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.storage.metadata.exception.UserNotExistException;
import org.storage.metadata.model.File;
import org.storage.metadata.model.User;
import org.storage.metadata.model.orchestrator.dto.FileUploadDTO;
import org.storage.metadata.repository.FileRepository;
import org.storage.metadata.repository.UserRepository;
import org.storage.metadata.security.services.CustomUserDetailsService;
import org.storage.metadata.validator.UserValidator;

import java.util.List;
import java.util.Optional;

@Service
public class FileService {
    private final UserRepository userRepository;
    private final FileRepository fileRepository;
    private final UserValidator userValidator;

    private final CustomUserDetailsService userDetailsService;

    private Authentication authentication;

    FileService(UserRepository userRepository, FileRepository fileRepository, UserValidator userValidator, CustomUserDetailsService userDetailsService) {
        this.userRepository = userRepository;
        this.fileRepository = fileRepository;
        this.userValidator = userValidator;
        this.userDetailsService = userDetailsService;
    }
    public List<File> getUserFiles(String usernameOrEmail) {
        userValidator.validateUser(usernameOrEmail);
        Optional<User> user = userRepository.findByUsernameOrEmail(usernameOrEmail, usernameOrEmail);
        if(!user.isPresent()) {
            throw new UserNotExistException();
        }
        return user.get().getFiles();
    }

    public Long insertFileData(FileUploadDTO fileUploadDto, String name) {
        //userValidator.validateUser(fileUploadDto.getUsernameOrEmail());
        //Fetching username
        String userName = name;
        return createFileObject(fileUploadDto,userName);
    }

    private Long createFileObject(FileUploadDTO fileUploadDto, String userName) {
        File file = new File();
        file.setDateCreated(System.currentTimeMillis());
        file.setType(fileUploadDto.getType());
        file.setNamespace(fileUploadDto.getNamespace());
        file.setIsDeleted(fileUploadDto.getIsDeleted());
        file.setIsDirectory(fileUploadDto.getIsDirectory());

        List<File> userFiles = getUserFiles(userName);
        userFiles.add(file);

        fileRepository.save(file);
        return file.getFile_id();
    }

    public void deleteFile(Long fileId) {
        try {
            fileRepository.deleteById(fileId);
        } catch (Exception e) {
            throw e;
        }
    }
}
