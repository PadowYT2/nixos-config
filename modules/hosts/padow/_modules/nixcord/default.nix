{inputs, ...}: {
  imports = [inputs.nixcord.nixosModules.nixcord];

  programs.nixcord = {
    enable = true;
    user = "padow";

    discord = {
      enable = true;
      branches = ["canary"];
      vencord.enable = false;
      equicord.enable = true;
      commandLineArgs = ["--ozone-platform=x11"];
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
        addAttachments.enable = true;
        alwaysAnimate.enable = true;
        alwaysExpandRoles = {
          enable = true;
          hideArrow = true;
        };
        alwaysTrust.enable = true;
        betterActivities.enable = true;
        betterBanReasons = {
          enable = true;
          isTextInputDefault = true;
        };
        betterBlockedUsers.enable = true;
        betterForwards = {
          enable = true;
          dontFollowForwards = true;
          selfForward = true;
        };
        betterGifAltText.enable = true;
        betterInvites.enable = true;
        betterRoleContext.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        biggerStreamPreview.enable = true;
        blurNsfw.enable = true;
        callTimer = {
          enable = true;
          allCallTimers = true;
          showSeconds = true;
          trackSelf = true;
          watchLargeGuilds = true;
        };
        cancelFriendRequest.enable = true;
        clearUrls.enable = true;
        clickableRoles.enable = true;
        clientTheme = {
          enable = true;
          color = "08080b";
        };
        clipUpload.enable = true;
        commandPalette = {
          hotkey = [];
        };
        copyEmojiMarkdown.enable = true;
        copyFileContents.enable = true;
        copyUserMention.enable = true;
        crashHandler.enable = true;
        customTimestamps = {
          formats.enable = false;
        };
        disableCallIdle.enable = true;
        disableCameras.enable = true;
        experiments.enable = true;
        expressionCloner.enable = true;
        f8Break.enable = true;
        favoriteEmojiFirst.enable = true;
        findReply.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendInvites.enable = true;
        gifPaste.enable = true;
        gifProviderSwitcher.enable = true;
        greetStickerPicker = {
          enable = true;
          greetMode = "Message";
        };
        homeTyping.enable = true;
        limitlessScreenshare = {
          enable = true;
          maxFps = 60;
        };
        loginWithQr.enable = true;
        memberCount = {
          enable = true;
          memberList = false;
          voiceActivity = false;
        };
        mentionAvatars.enable = true;
        messageLatency = {
          enable = true;
          showMillis = true;
        };
        moreQuickReactions = {
          enable = true;
          reactionCount = 0;
        };
        moreUserTags = {
          tagSettings = {
            administrator.enable = false;
            chatModerator.enable = false;
            moderator.enable = false;
            moderatorStaff.enable = false;
            owner.enable = false;
            voiceModerator.enable = false;
            webhook.enable = false;
            enable = false;
          };
        };
        noDevtoolsWarning.enable = true;
        noF1.enable = true;
        noMaskedUrlPaste.enable = true;
        noMiddleClickPaste.enable = true;
        noOnboardingDelay.enable = true;
        noPushToTalk.enable = true;
        noReplyMention = {
          enable = true;
          roleList = "";
          userList = "";
        };
        noUnblockToJump.enable = true;
        overrideForumDefaults.enable = true;
        pauseInvitesForever.enable = true;
        permissionFreeWill.enable = true;
        permissionsViewer.enable = true;
        questify = {
          enable = true;
          acknowledgedNotices = {
            quest-ban-warning-2026-08-07 = true;
            quest-ban-warning-2026-08-26 = true;
          };
          newQuestAlertSound = "discodo"; # 4evy/nixcord#252
          questButtonBadgeCount = 11;
          questButtonDisplay = "never";
          questCompletedAlertSound = ""; # 4evy/nixcord#252
        };
        randomVoice = {
          keybind = [];
        };
        reactionTimestamps.enable = true;
        revealAllSpoilers.enable = true;
        searchFix.enable = true;
        showHiddenThings.enable = true;
        spotifyCrack.enable = true;
        spotifyShareCommands.enable = true;
        stickerPaste.enable = true;
        themeAttributes.enable = true;
        unlimitedAccounts.enable = true;
        userVoiceShow = {
          enable = true;
          showInMemberList = false;
          showInMessages = false;
        };
        validReply.enable = true;
        validUser.enable = true;
        vcNarrator = {
          voice = null;
        };
        viewIcons = {
          enable = true;
          format = "png";
        };
        viewRaw.enable = true;
        voiceChatUtilities.enable = true;
        voiceMessages = {
          enable = true;
          echoCancellation = false;
          noiseSuppression = false;
        };
        voiceMessagesInBackground.enable = true;
        voiceRejoin.enable = true;
        volumeBooster = {
          enable = true;
          multiplier = 5.0;
        };
        whosWatching.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };
}
