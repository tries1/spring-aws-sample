package com.sample.spring.web;

import com.sample.spring.services.posts.PostsService;
import com.sample.spring.web.dto.PostsResponseDto;
import com.sample.spring.web.dto.PostsSaveRequestDto;
import com.sample.spring.web.dto.PostsUpdateRequestDto;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class PostsApiController {
    private final PostsService postsService;

    @GetMapping("/api/v1/posts/{id}")
    public PostsResponseDto findById(@PathVariable Long id) {
        return postsService.findById(id);
    }

    @PostMapping("/api/v1/posts")
    public Long save(@RequestBody PostsSaveRequestDto postsSaveRequestDto) {
        return postsService.save(postsSaveRequestDto);
    }

    @PutMapping("/api/v1/posts/{id}")
    public Long update(@RequestBody PostsUpdateRequestDto postsUpdateRequestDto, @PathVariable Long id) {
        return postsService.update(id, postsUpdateRequestDto);
    }
}
