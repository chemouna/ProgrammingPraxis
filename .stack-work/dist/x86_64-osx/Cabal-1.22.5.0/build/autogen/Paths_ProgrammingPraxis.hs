module Paths_ProgrammingPraxis (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/mounacheikhna/Documents/repos/mine/ProgrammingPraxis/.stack-work/install/x86_64-osx/lts-6.13/7.10.3/bin"
libdir     = "/Users/mounacheikhna/Documents/repos/mine/ProgrammingPraxis/.stack-work/install/x86_64-osx/lts-6.13/7.10.3/lib/x86_64-osx-ghc-7.10.3/ProgrammingPraxis-0.1.0.0-KXYHnJRDSMJ69vZ4QX0cLg"
datadir    = "/Users/mounacheikhna/Documents/repos/mine/ProgrammingPraxis/.stack-work/install/x86_64-osx/lts-6.13/7.10.3/share/x86_64-osx-ghc-7.10.3/ProgrammingPraxis-0.1.0.0"
libexecdir = "/Users/mounacheikhna/Documents/repos/mine/ProgrammingPraxis/.stack-work/install/x86_64-osx/lts-6.13/7.10.3/libexec"
sysconfdir = "/Users/mounacheikhna/Documents/repos/mine/ProgrammingPraxis/.stack-work/install/x86_64-osx/lts-6.13/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ProgrammingPraxis_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ProgrammingPraxis_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "ProgrammingPraxis_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ProgrammingPraxis_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ProgrammingPraxis_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
