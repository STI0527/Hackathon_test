package com.example.shop.services;


import com.example.shop.enums.Role;
import com.example.shop.models.Avatar;
import com.example.shop.models.Image;
import com.example.shop.models.User;
import com.example.shop.repositories.AvatarRepository;
import com.example.shop.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AvatarRepository avatarRepository;
    public boolean createUser(User user, MultipartFile fileAvatar) throws IOException {
        if(userRepository.findByEmail(user.getEmail()) != null)
            return false;


        Avatar imageAvatar;
        if(fileAvatar.getSize() != 0){
            imageAvatar = toAvatarEntity(fileAvatar);
            assert imageAvatar != null;
            user.addAvatar(imageAvatar);
        }
        else{
           imageAvatar = new Avatar(user.getId(), avatarRepository.getReferenceById(0l).getName(),
                   avatarRepository.getReferenceById(0l).getOriginalFileName(),  avatarRepository.getReferenceById(0l).getSize(),
                   avatarRepository.getReferenceById(0l).getContentType(), avatarRepository.getReferenceById(0l).getBytes(),user);
//           imageAvatar.setName(avatarRepository.getReferenceById(0l).getName());
//           imageAvatar.setSize(avatarRepository.getReferenceById(0l).getSize());
//           imageAvatar.setContentType(avatarRepository.getReferenceById(0l).getContentType());
//           imageAvatar.setBytes(avatarRepository.getReferenceById(0l).getBytes());
//           imageAvatar.setOriginalFileName(avatarRepository.getReferenceById(0l).getOriginalFileName());
//
            user.setAvatar(imageAvatar);
            //user.addAvatar(imageAvatar);
        }


        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        log.info("\u001B[31mSaving new User with email {}\u001B[0m", user.getEmail());
        userRepository.save(user);
        return true;

    }


    public Avatar toAvatarEntity(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return null;
        }

        Avatar avatar = new Avatar();
        avatar.setName(file.getName());
        avatar.setOriginalFileName(file.getOriginalFilename());
        avatar.setContentType(file.getContentType());
        avatar.setSize(file.getSize());
        avatar.setBytes(file.getBytes());
        return avatar;

    }


    public List<User> list(){
        return userRepository.findAll();
    }


    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if(user != null){
            if(user.isActive()) {
                user.setActive(false);
                log.info("\u001B[31mBan user with id {}; email {}\u001B[0m", user.getId(), user.getEmail());
            }
            else{
                user.setActive(true);
                log.info("\u001B[31mUnbanned user with id {}; email {}\u001B[0m", user.getId(), user.getEmail());
            }
        }
        userRepository.save(user);
    }

    public void changeUserRole(User user, String role){
        user.getRoles().clear();
        user.getRoles().add(Role.valueOf(role));

        userRepository.save(user);
    }

    public User getUserById(Long id){
        return userRepository.findById(id).orElse(null);
    }
}
