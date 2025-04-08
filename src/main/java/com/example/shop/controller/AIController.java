package com.example.shop.controller;

import com.example.shop.services.AiService;
import lombok.RequiredArgsConstructor;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STRestartNumber;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/api/ai")
@RequiredArgsConstructor
public class AIController {

    private final AiService aiService;

//    http://localhost:1799/api/ai/ai_response

    @PostMapping("/ask")
    public String askAI(@RequestParam("question") String question,
                        Model model) {

        String answer = aiService.ask(question);
        model.addAttribute("ai_response", answer);
        return "ai_response";
    }

    @GetMapping("/ai_response")
    public String getAiResponsePage(){
        return "ai_response";
    }

}
