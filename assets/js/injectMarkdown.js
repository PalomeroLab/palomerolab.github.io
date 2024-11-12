/**
 * @file injectMarkdown.js
 * @brief Fetches a markdown file from a specified URL, converts it to HTML, and injects its content into multiple sections.
 */

// Ensure that marked is correctly loaded
if (typeof marked === "undefined") {
  console.error("marked.js is not loaded correctly.");
} else {
  console.log("marked.js is available.");
}

/**
 * Fetches a markdown file from the provided URL, converts it to HTML, and injects it into the specified element.
 * @param {string} filePath - The URL or path to the raw markdown file.
 * @param {string} elementId - The ID of the element where the converted HTML will be injected.
 */
export async function injectMarkdownFromUrl(filePath, elementId) {
  const url = `https://raw.githubusercontent.com/PalomeroLab/palomerolab.github.io/main/${filePath}`;

  try {
    // Fetch the markdown content
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to fetch the markdown file: ${response.status}`);
    }
    const markdownText = await response.text();

    // Convert the markdown content to HTML using marked.js
    const htmlContent = marked(markdownText);

    // Inject the HTML into the target element
    const targetElement = document.getElementById(elementId);
    if (!targetElement) {
      throw new Error(`Element with id ${elementId} not found`);
    }
    targetElement.innerHTML = htmlContent;
  } catch (error) {
    console.error("Error loading or converting markdown:", error);
  }
}
