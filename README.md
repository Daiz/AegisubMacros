# Introduction

This repository contains various small Aegisub Automation macros that I've written. Idea shamelessly taken from [Lyger's fantastic script repository](https://github.com/lyger/Aegisub_automation_scripts). Here are descriptions for the currently available scripts.

## cpscalc.lua - CPS Calculator

This script can be used to calculate the characters per second for dialogue. You can read about the importance of text length in subtitles [here](http://8ths.in/fantranslation-guide/) (look for the section **Make everything as simple as possible, but not simpler**). The script processes all lines by default where the style name matches either "Default", "Alternative" or "Overlap", and adds warnings for lines that go above 18 CPS. Note that this macro uses the effect field for the CPS value, but this should generally not be an issue since dialogue should practically never use the Effect field otherwise. You can and should rerun the script as you make edits, because it only updates the values when you run it. The script also comes with another macro that can be used to clean the effect field if desired.

## cmconv.lua - BT.601➡BT.709 Color Converter

If you have some scripts with colors matched to video with Aegisub's "Force BT.601" setting turned on (currently on by default, but this will change in Aegisub at some point) and want to easily convert the colors to BT.709 (what your video most likely is if it isn't sourced from a DVD), this script does the job. Comes with two macros, one that only processes inline color definitions on selected lines, and one that alters all colors everywhere in the script (both in styles and lines).

To convert a BT.601 script to BT.709 correctly, you can simply run the global fixer without video open and save afterwards. If you have video open, you should run the script, reopen the video and only then save (if you save without reopening the video the header tag could still be incorrectly BT.601).

## autoswapper.lua - Autoswapper

Autoswapper gives you several macros to perform swap operations on a script according to a specific syntax and control characters. Here's an example of the syntax using * as the control characters:

```
Shiver me timbers, Jimmy{**-kun}!
What is it, {*}Dad{*Otou-san}?
```

By running the matching macro, the lines turn into:

```
Shiver me timbers, Jimmy{*}-kun{*}!
What is it, {*}Otou-san{*Dad}?
```

By re-running the macro, you get back to what it originally was. Simple as that.

The script runs on the whole script by default, but it only performs swap operations on lines where the stylename includes either "Default", "Alternative" or "Overlap".

The script also allows you to toggle lines on and off - if you put three control characters in the line's effect field (eg. `***`) then the line will be made into a comment if it's not and into a regular line if it's a comment when the matching macro is ran. This check is done for all lines regardless of the style, and the toggle will only be performed if the effect field contains the three control characters and nothing else (so for example, `****` or `(23) *****` would not trigger a toggle).