# Introduction

This repository contains various small Aegisub Automation macros that I've written. Idea shamelessly taken from [Lyger's fantastic script repository](https://github.com/lyger/Aegisub_automation_scripts). Here are descriptions for the currently available scripts.

## cpscalc.lua - CPS Calculator

This script can be used to calculate the characters per second for dialogue. You can read about the importance of text length in subtitles [here](http://8ths.in/fantranslation-guide/) (look for the section **Make everything as simple as possible, but not simpler**). The script processes all lines by default where the style name matches either "Default", "Alternative" or "Overlap", and adds warnings for lines that go above 18 CPS. Note that this macro uses the effect field for the CPS value, but this should generally not be an issue since dialogue should practically never use the Effect field otherwise. You can and should rerun the script as you make edits, because it only updates the values when you run it. The script also comes with another macro that can be used to clean the effect field if desired.

## cmconv.lua - BT.601➡BT.709 Color Converter

If you have some scripts with colors matched to video with Aegisub's "Force BT.601" setting turned on (currently on by default, but this will change in Aegisub 3.1) and want to easily convert the colors to BT.709 (what your video most likely is if it isn't sourced from a DVD), this script does the job. Comes with two macros, one that only processes inline color definitions on selected lines, and one that alters all colors everywhere in the script (both in styles and lines).

## autoreplacer.lua - Autoreplacer

You can use this to swap lines between two alternatives in an easy fashion. Consider the following lines:

```
Shiver me timbers, Jimmy{**-kun}!
What is it, {*}Dad{*Otou-san}?
```

By running the script, the lines turn into:

```
Shiver me timbers, Jimmy{*}-kun{*}!
What is it, {*}Otou-san{*Dad}?
```

By re-running the script, you get back to what it originally was. Simple as that.