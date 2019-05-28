package com.guonl.controller;

import com.guonl.vo.FrontResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by guonl
 * Date: 2019-05-28 14:59
 * Description: 一个测试的url
 */
@RequestMapping("/hello")
@RestController
public class HelloController {

    @RequestMapping(value = "/{name}", method = {RequestMethod.GET, RequestMethod.POST})
    public FrontResult test(@PathVariable String name) {
        String hello = "欢迎您，" + name;
        return FrontResult.success(hello);
    }
}
