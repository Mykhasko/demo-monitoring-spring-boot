package com.example.demo.monitoring.spring.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {

  @GetMapping("/")
  public String index(Model model) {
    model.addAttribute("message", "Hello, World!");
    return "index"; // This will resolve to src/main/resources/templates/index.html

  }
}
