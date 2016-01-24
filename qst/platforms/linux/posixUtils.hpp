/******************************************************************************
// QSyncthingTray
// Copyright (c) Matthias Frick, All rights reserved.
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3.0 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library.
******************************************************************************/

#ifndef QSyncthingTray_posixUtils_hpp
#define QSyncthingTray_posixUtils_hpp
#include <sstream>
#include <string>
#include <iostream>
#define UNUSED(x) (void)(x)

namespace qst
{
namespace platforms
{
namespace linux
{
  struct PosixUtils
  {
    char getPlatformDelimiter()
    {
      return '/';
    }

    // stubbed out, does nothing on linux
    void showDockIcon(bool show) 
    {
    UNUSED(show);
    }

    std::string getSSLLibraryText()
    {
      return std::string("In order to use HTTPS URLs on Linux, please \
        install OpenSSL");
    }

    static bool isBinaryRunning(std::string binary)
    {
      const char* someapp = binary.c_str();
      std::stringstream cmd;
      
      cmd << "ps -ef | grep " << someapp << " | grep -v grep -c";
      
      FILE* app = popen(cmd.str().c_str(), "r");
      char instances = '0';
      
      if (app)
      {
        size_t x = fread(&instances, sizeof(instances), 1, app);
        UNUSED(x);
        pclose(app);
      }
      bool result = instances == '0' ? false : true;
      return result;
    }

  };
} // posix
} // sysutils
} // qst

#endif
