package com.example.minikubedemo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class HelloEndpoint
{
  @GetMapping
  public String sayHello(){
    return "Hello from APP "+System.currentTimeMillis();
  }
}
