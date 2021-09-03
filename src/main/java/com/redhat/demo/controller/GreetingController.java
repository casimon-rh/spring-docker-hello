package com.redhat.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class GreetingController {

  @Value("${greeting.app}")
  String app;
  @GetMapping("/greeting")
  public String greeting(@RequestParam(name="name", required =false, defaultValue = "World") String name, Model model){
    model.addAttribute("name", name);
    model.addAttribute("app", app);
    return "greeting";
  }
  @GetMapping("/color")
  public String color(Model model){
    return "color";
  }
}
