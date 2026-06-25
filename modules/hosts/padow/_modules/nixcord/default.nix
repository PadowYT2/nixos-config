{inputs, ...}: {
  imports = [inputs.nixcord.nixosModules.nixcord];

  programs.nixcord = {
    enable = true;
    user = "padow";

    discord = {
      enable = true;
      branch = "canary";
      vencord.enable = false;
      equicord.enable = true;
    };

    quickCss = ''
      :root {
        --font-code: "Monocraft";
      }
    '';

    config = {
      useQuickCss = true;
      enableReactDevtools = true;
      disableMinSize = true;
      plugins = {
        alwaysAnimate = {
          enable = true;
          icons = true;
          nameplates = true;
          roleGradients = true;
          serverBanners = true;
          statusEmojis = true;
        };
        alwaysExpandRoles = {
          enable = true;
          hideArrow = true;
        };
        alwaysTrust = {
          confirmModal = true;
          domain = true;
          enable = true;
          file = true;
          noDeleteSafety = true;
        };
        betterActivities = {
          allActivitiesStyle = "carousel";
          enable = true;
          hideTooltip = true;
          iconSize = 15.0;
          memberList = true;
          removeGameActivityStatus = false;
          renderGifs = true;
          specialFirst = true;
          userPopout = true;
        };
        betterBanReasons = {
          enable = true;
          isTextInputDefault = true;
          reasons = [];
        };
        betterBlockedUsers = {
          enable = true;
        };
        betterGifAltText = {
          enable = true;
        };
        betterInvites = {
          enable = true;
        };
        betterRoleContext = {
          enable = true;
          roleIconFileFormat = "png";
        };
        betterSessions = {
          backgroundCheck = false;
          checkInterval = 20;
          enable = true;
        };
        betterSettings = {
          disableFade = true;
          eagerLoad = true;
          enable = true;
          organizeMenu = true;
        };
        biggerStreamPreview = {
          enable = true;
        };
        blurNsfw = {
          blurAllChannels = false;
          blurAmount = 10;
          enable = true;
        };
        callTimer = {
          allCallTimers = true;
          enable = true;
          format = "stopwatch";
          showRoleColor = false;
          showSeconds = true;
          showWithoutHover = false;
          trackSelf = true;
          watchLargeGuilds = true;
        };
        cancelFriendRequest = {
          enable = true;
        };
        clearUrls = {
          enable = true;
        };
        clickableRoles = {
          enable = true;
        };
        clientTheme = {
          color = "08080b";
          enable = true;
        };
        copyEmojiMarkdown = {
          copyUnicode = true;
          enable = true;
        };
        copyFileContents = {
          enable = true;
        };
        copyUserMention = {
          enable = true;
        };
        crashHandler = {
          attemptToNavigateToHome = false;
          attemptToPreventCrashes = true;
          enable = true;
        };
        disableCallIdle = {
          enable = true;
        };
        disableCameras = {
          enable = true;
        };
        experiments = {
          enable = true;
          toolbarDevMenu = false;
        };
        expressionCloner = {
          enable = true;
        };
        f8Break = {
          enable = true;
        };
        favoriteEmojiFirst = {
          enable = true;
        };
        findReply = {
          enable = true;
          hideButtonIfNoReply = true;
          includeAuthor = false;
          includePings = false;
        };
        fixSpotifyEmbeds = {
          enable = true;
          volume = 10.0;
        };
        fixYoutubeEmbeds = {
          enable = true;
          youtubeDescription = false;
        };
        forceOwnerCrown = {
          enable = true;
        };
        friendInvites = {
          enable = true;
        };
        gifPaste = {
          enable = true;
        };
        greetStickerPicker = {
          enable = true;
          greetMode = "Message";
        };
        homeTyping = {
          enable = true;
        };
        loginWithQr = {
          enable = true;
        };
        memberCount = {
          enable = true;
          memberList = false;
          toolTip = true;
          voiceActivity = false;
        };
        mentionAvatars = {
          enable = true;
          showAtSymbol = true;
        };
        messageLatency = {
          detectDiscordKotlin = true;
          enable = true;
          ignoreSelf = false;
          latency = 2;
          showMillis = true;
        };
        moreQuickReactions = {
          columns = 4.0;
          compactMode = false;
          enable = true;
          frequentEmojis = true;
          reactionCount = 0;
          rows = 2.0;
          scroll = true;
        };
        noDevtoolsWarning = {
          enable = true;
        };
        noF1 = {
          enable = true;
        };
        noMaskedUrlPaste = {
          enable = true;
        };
        noMiddleClickPaste = {
          enable = true;
        };
        noOnboardingDelay = {
          enable = true;
        };
        noPushToTalk = {
          enable = true;
        };
        noReplyMention = {
          enable = true;
          inverseShiftReply = false;
          roleList = "";
          shouldPingListed = true;
          userList = "";
        };
        noUnblockToJump = {
          enable = true;
        };
        overrideForumDefaults = {
          defaultLayout = 1;
          defaultSortOrder = 0;
          enable = true;
        };
        pauseInvitesForever = {
          enable = true;
        };
        permissionFreeWill = {
          enable = true;
          lockout = true;
          onboarding = true;
        };
        permissionsViewer = {
          enable = true;
          permissionsSortOrder = 0;
        };
        questify = {
          allowChangingDangerousSettings = false;
          autoCompleteQuestTypes = {
            PLAY_ON_DESKTOP = false;
            PLAY_ON_XBOX = false;
            PLAY_ON_PLAYSTATION = false;
            PLAY_ACTIVITY = false;
            WATCH_VIDEO = false;
            WATCH_VIDEO_ON_MOBILE = false;
            ACHIEVEMENT_IN_ACTIVITY = false;
          };
          autoCompleteQuestsSimultaneously = false;
          claimedSubsort = "Claimed DESC";
          completeVideoQuestsQuicker = false;
          disableAccountPanelPromo = true;
          disableAccountPanelQuestProgress = false;
          disableFriendsListPromo = true;
          disableMembersListPromo = true;
          disableOrbsAndQuestsBadges = false;
          disableQuestsEverything = false;
          disableRelocationNotices = true;
          disableSponsoredBanner = false;
          enable = true;
          expiredSubsort = "Expiring DESC";
          ignoredQuestIds = {
            questIDs = [
            ];
          };
          ignoredSubsort = "Recent DESC";
          isOnQuestsPage = false;
          lastQuestPageFilters = {
          };
          lastQuestPageSort = "questify";
          makeMobileVideoQuestsDesktopCompatible = false;
          migrationVersion = 1;
          newExcludedQuestAlertSound = null;
          newExcludedQuestAlertVolume = 100;
          newQuestAlertSound = "discodo";
          newQuestAlertVolume = 100;
          notifyOnNewExcludedQuests = false;
          notifyOnNewQuests = true;
          notifyOnQuestComplete = true;
          questButtonBadgeColor = 2842239;
          questButtonBadgeCount = 15;
          questButtonDisplay = "never";
          questButtonIncludedTypes = {
            "1" = true;
            "2" = true;
            "3" = true;
            "4" = true;
            "5" = true;
            WATCH_VIDEO = true;
            WATCH_VIDEO_ON_MOBILE = true;
            ACHIEVEMENT_IN_ACTIVITY = true;
            ACHIEVEMENT_IN_GAME = true;
            PLAY_ACTIVITY = true;
            PLAY_ON_DESKTOP = true;
            PLAY_ON_DESKTOP_V2 = true;
            STREAM_ON_DESKTOP = true;
            PLAY_ON_PLAYSTATION = true;
            PLAY_ON_XBOX = true;
          };
          questButtonIndicator = "both";
          questButtonLeftClickAction = "open-quests";
          questButtonMiddleClickAction = "plugin-settings";
          questButtonRightClickAction = "context-menu";
          questCompletedAlertSound = "bop_message1";
          questCompletedAlertVolume = 100;
          questFetchInterval = 2700;
          questOrder = [
            "UNCLAIMED"
            "CLAIMED"
            "IGNORED"
            "EXPIRED"
          ];
          questTileClaimedColor = {
            enable = true;
            color = 6105983;
          };
          questTileExpiredColor = {
            enable = true;
            color = 2368553;
          };
          questTileGradient = "intense";
          questTileIgnoredColor = {
            enable = true;
            color = 8334124;
          };
          questTilePreload = true;
          questTileUnclaimedColor = {
            enable = true;
            color = 2842239;
          };
          rememberQuestPageFilters = true;
          rememberQuestPageSort = true;
          resumeInterruptedQuests = false;
          resumeQuestIds = {
          };
          unclaimedSubsort = "Expiring ASC";
        };
        revealAllSpoilers = {
          enable = true;
        };
        searchFix = {
          enable = true;
        };
        selfForward = {
          enable = true;
        };
        showHiddenThings = {
          enable = true;
          showInvitesPaused = true;
          showModView = true;
          showTimeouts = true;
        };
        spotifyCrack = {
          enable = true;
          keepSpotifyActivityOnIdle = false;
          noSpotifyAutoPause = true;
        };
        spotifyShareCommands = {
          enable = true;
        };
        stickerPaste = {
          enable = true;
        };
        themeAttributes = {
          enable = true;
        };
        unlimitedAccounts = {
          enable = true;
          maxAccounts = 0;
        };
        userVoiceShow = {
          enable = true;
          showInMemberList = false;
          showInMessages = false;
          showInUserProfileModal = true;
        };
        validReply = {
          enable = true;
        };
        validUser = {
          enable = true;
        };
        viewIcons = {
          enable = true;
          format = "png";
          imgSize = "1024";
        };
        viewRawVariant = {
          enable = true;
        };
        voiceChatUtilities = {
          enable = true;
          waitAfter = 5.0;
          waitSeconds = 2.0;
        };
        voiceMessages = {
          echoCancellation = false;
          enable = true;
          noiseSuppression = false;
        };
        voiceRejoin = {
          applyOnlyToDms = false;
          enable = true;
          preventReconnectIfCallEnded = "both";
          rejoinDelay = 2.0;
          rejoinTimeout = 30.0;
        };
        volumeBooster = {
          enable = true;
          multiplier = 5.0;
        };
        whosWatching = {
          enable = true;
          showPanel = true;
        };
        youtubeAdblock = {
          enable = true;
        };
      };
    };
  };
}
