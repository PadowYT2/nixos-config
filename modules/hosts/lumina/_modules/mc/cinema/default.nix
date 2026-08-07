{
  pkgs,
  inputs,
  ...
}: {
  imports = [(inputs.import-tree ./mods)];

  services.minecraft-servers.servers.cinema = {
    enable = true;
    autoStart = false;
    jvmOpts = "-Djna.library.path=${pkgs.lib.makeLibraryPath [pkgs.udev]} -Xms32768M -Xmx32768M -XX:+UseZGC -XX:-ZProactive -XX:SoftMaxHeapSize=30720M -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:+PerfDisableSharedMem -XX:+UseNUMA -XX:-DontCompileHugeMethods -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:ReservedCodeCacheSize=400M -XX:NonNMethodCodeHeapSize=12M -XX:ProfiledCodeHeapSize=194M -XX:NonProfiledCodeHeapSize=194M -XX:NmethodSweepActivity=1 -XX:+UseFastUnorderedTimeStamps -XX:+UseCriticalJavaThreadPriority -XX:AllocatePrefetchStyle=1 -XX:+AlwaysActAsServerClassMachine -XX:+UseTransparentHugePages -XX:LargePageSizeInBytes=2M -XX:+UseLargePages -XX:+EagerJVMCI -XX:+UseStringDeduplication -XX:+UseAES -XX:+UseAESIntrinsics -XX:+UseFMA -XX:+UseLoopPredicate -XX:+RangeCheckElimination -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+UseThreadPriorities -XX:+OmitStackTraceInFastThrow -XX:+RewriteBytecodes -XX:+RewriteFrequentPairs -XX:+UseFPUForSpilling -XX:+UseFastStosb -XX:+UseNewLongLShift -XX:+UseVectorCmov -XX:+UseXMMForArrayCopy -XX:+UseXmmI2D -XX:+UseXmmI2F -XX:+UseXmmLoadAndClearUpper -XX:+UseXmmRegToRegMoveAll -XX:+EliminateLocks -XX:+DoEscapeAnalysis -XX:+AlignVector -XX:+OptimizeFill -XX:+EnableVectorSupport -XX:+UseCharacterCompareIntrinsics -XX:+UseCopySignIntrinsic -XX:+UseVectorStubs -XX:UseAVX=2 -XX:UseSSE=4 -XX:+UseFastJNIAccessors -XX:+UseInlineCaches -XX:+SegmentedCodeCache -Djdk.nio.maxCachedBufferSize=262144 -Djdk.graal.UsePriorityInlining=true -Djdk.graal.Vectorization=true -Djdk.graal.OptDuplication=true -Djdk.graal.DetectInvertedLoopsAsCounted=true -Djdk.graal.LoopInversion=true -Djdk.graal.VectorizeHashes=true -Djdk.graal.EnterprisePartialUnroll=true -Djdk.graal.VectorizeSIMD=true -Djdk.graal.StripMineNonCountedLoops=true -Djdk.graal.SpeculativeGuardMovement=true -Djdk.graal.TuneInlinerExploration=1 -Djdk.graal.LoopRotation=true -Djdk.graal.CompilerConfiguration=enterprise --add-modules=jdk.incubator.vector";
    package = pkgs.neoforgeServers.neoforge-1_21_1.overrideAttrs (_old: {
      jdk = pkgs.graalvmPackages.graalvm-oracle;
    });

    whitelist = {
      PadowYT2 = "b8cf1af3-7dea-4338-bd7d-0f09f4e9d33c";
      kony_ogony = "f1b1cf9a-1417-48ef-a68d-c0a461c8e208";
      YellowRun = "98785c54-6b91-4c14-bd15-744813583287";
    };

    serverProperties = {
      server-port = 25565;
      white-list = true;
      allow-flight = true;
      allow-nether = false;
      spawn-monsters = false;
      gamemode = "creative";
      enforce-secure-profile = false;
      max-players = 1000;
      view-distance = 16;
      simulation-distance = 16;
      spawn-protection = 0;
      level-type = "minecraft:flat";
      generate-structures = false;
    };
  };
}
