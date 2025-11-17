#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Github Image Prettifier
// @raycast.mode silent
// @raycast.icon 🖼️

// Optional parameters:
// @raycast.packageName GitHub Utils

// Documentation:
// @raycast.description Convert GitHub image markdown to HTML or table format depending on the number of images and paste at cursor
// @raycast.author Rory O'Connor
// @raycast.authorURL https://github.com/roconnorr

const { exec } = require("child_process");

const singleImageWidth = 300;

// Read input from clipboard
exec("pbpaste", (error, stdout, stderr) => {
  if (error) {
    console.error(`Error reading clipboard: ${error.message}`);
    process.exit(1);
  }
  
  if (stderr) {
    console.error(`Error: ${stderr}`);
    process.exit(1);
  }
  
  const clipboardContent = stdout.trim();
  
  // Extract ALL image URLs using regex - more permissive to catch different URL formats
  const markdownRegex = /!\[(.*?)\]\((https?:\/\/[^\s)]+)\)/g;
  const htmlRegex = /<img[^>]*\ssrc="(https?:\/\/[^\s"]+)"[^>]*\salt="([^"]*)"[^>]*>/g;

  const markdownMatches = [...clipboardContent.matchAll(markdownRegex)];
  const htmlMatches = [...clipboardContent.matchAll(htmlRegex)];

  // Combine matches, normalizing the format
  const matches = [
    ...markdownMatches,
    // For HTML matches, swap the positions to match [full match, alt, src]
    ...htmlMatches.map(match => [match[0], match[2], match[1]])
  ];

  if (matches.length === 0) {
    console.error("No GitHub image URLs found in clipboard");
    process.exit(1);
  }
  
  let outputContent = "";
  
  if (matches.length === 1) {
    // Single image format, set width
    outputContent = `<img src="${matches[0][2]}" width="${singleImageWidth}">`;
  } else {
    // Table format with before/after and max 2 per row
    outputContent = "|Screenshots Before|Screenshots After|\n|-|-|\n";
    
    // Process matches in pairs
    for (let i = 0; i < matches.length; i += 2) {
      const before = matches[i];
      const after = matches[i + 1]; // might be undefined if odd number
      
      outputContent += `|![${before[1]}](${before[2]})|`;
      
      if (after) {
        outputContent += `![${after[1]}](${after[2]})|\n`;
      } else {
        outputContent += "|\n"; // Empty cell if no matching "after" image
      }
    }
  }
  
  // Put the output content in the clipboard - escape special characters properly
  exec(`echo "${outputContent.replace(/"/g, '\\"')}" | pbcopy`, (error) => {
    if (error) {
      console.error(`Error copying to clipboard: ${error.message}`);
      process.exit(1);
    }
    
    // Use AppleScript to paste at current cursor position
    // Adding a small delay to ensure clipboard is ready
    const appleScript = `
      delay 0.1
      tell application "System Events"
        keystroke "v" using command down
      end tell
    `;
    
    exec(`osascript -e "${appleScript.replace(/"/g, '\\"')}"`, (error) => {
      if (error) {
        console.error(`Error pasting at cursor: ${error.message}`);
        process.exit(1);
      }
    });
  });
});
