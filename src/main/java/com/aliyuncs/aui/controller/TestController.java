package com.aliyuncs.aui.controller;

import com.aliyuncs.aui.common.utils.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 测试控制器，用于验证CORS配置
 */
@RestController
@RequestMapping("/api/test")
@CrossOrigin(origins = "*")
@Slf4j
public class TestController {

    @GetMapping("/cors")
    public Result testCors() {
        log.info("CORS test endpoint called");
        return Result.ok().put("message", "CORS is working!");
    }

    @PostMapping("/cors")
    public Result testCorsPost(@RequestBody(required = false) Object data) {
        log.info("CORS POST test endpoint called with data: {}", data);
        return Result.ok().put("message", "CORS POST is working!");
    }

    @RequestMapping(value = "/cors", method = RequestMethod.OPTIONS)
    public Result handleOptions() {
        log.info("OPTIONS request received");
        return Result.ok().put("message", "OPTIONS handled");
    }
} 