/**
 * @file injectMarkdown.js
 * @brief Fetches a markdown file from a specified URL, converts it to HTML, and injects its content into the specified element.
 */

/**
 * Fetches a markdown file from the provided URL, converts it to HTML, and injects it into the specified element.
 *
 * @async
 * @function injectMarkdownFromUrl
 * @param {string} filePath - The URL or path to the markdown file.
 * @param {string} elementId - The ID of the HTML element where the converted HTML will be injected.
 * @throws Will throw an error if the markdown file cannot be fetched or if the specified element is not found.
 *
 * @details
 * This function uses the `fetch` API to retrieve markdown content, then converts it to HTML using the `marked` library.
 * After conversion, it injects the HTML content into the target element specified by `elementId`.
 */
async function injectMarkdownFromUrl(filePath, elementId) {
  console.log(`Attempting to fetch markdown file from: ${filePath}`);

  const url = `https://raw.githubusercontent.com/PalomeroLab/palomerolab.github.io/main/${filePath}`;

  try {
    console.log(`Fetching markdown content from: ${url}`);
    // Fetch the markdown content
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to fetch the markdown file: ${response.status}`);
    }
    const markdownText = await response.text();
    console.log("Markdown file fetched successfully");

    // Convert the markdown content to HTML using marked.js
    console.log("Converting markdown to HTML...");
    const htmlContent = marked.parse(markdownText);

    // Inject the HTML into the target element
    const targetElement = document.getElementById(elementId);
    if (!targetElement) {
      throw new Error(`Element with id ${elementId} not found`);
    }
    console.log(`Injecting HTML content into element with ID: ${elementId}`);
    targetElement.innerHTML = htmlContent;

    console.log("Markdown injected successfully into the page.");
  } catch (error) {
    console.error("Error loading or converting markdown:", error);
  }
}

// Add this call to execute the function when the document is ready
document.addEventListener("DOMContentLoaded", function () {
  console.log("Document loaded, calling injectMarkdownFromUrl...");
  injectMarkdownFromUrl("assets/bios/about.md", "about-content");
  injectMarkdownFromUrl("assets/bios/teresa.md", "teresa-bio");
});

console.log("injectMarkdown.js script loaded");
