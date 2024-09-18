package com.example.grupo2gtics.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
@Controller
@RequestMapping("/coordinador")
public class CoordiController {
    @GetMapping("")
    public String Coordi(Model model, @RequestParam(required= false) String zona){return "redirect:/sneat-1.0.0/html/CoordinadorZonal/inicio_coordinador_zonal.html";}
}
