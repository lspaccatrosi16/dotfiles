local jdtls = require("jdtls")

local config = require("lspaccatrosi16/remaps.config")
local sec = config.sections:add("j", "java")

sec.add("n", "dc", jdtls.test_class, "tests class")
sec.add("n", "dm", jdtls.test_nearest_method, "tests method")
sec.add("n", "o", jdtls.organize_imports, "organise imports")
sec.add("n", "xv", jdtls.extract_variable, "extract variable")
sec.add("x", "xv", function() jdtls.extract_variable(true) end, "extract variable")
sec.add("n", "xc", jdtls.extract_constant, "extract constant")
sec.add("x", "xc", function() jdtls.extract_constant(true) end, "extract constant")
sec.add("x", "xc", function() jdtls.extract_method(true) end, "extract methods")
