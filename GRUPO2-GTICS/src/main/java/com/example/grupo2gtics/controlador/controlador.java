package com.example.grupo2gtics.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class controlador {
    @GetMapping("")
    public String index(){
        return "index";
    }
}
