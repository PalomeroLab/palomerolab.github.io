/**
 * @file scripts.js
 * @brief A combined script for injecting markdown files and rendering lab member data.
 */

/**
 * Generic fetch function to retrieve data from a URL.
 * @param {string} url - The URL to fetch data from.
 * @returns {Promise<string|Object>} The fetched data, either as text (for markdown) or as JSON (for people data).
 * @throws Will throw an error if the fetch fails.
 */
async function fetchData(url) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to fetch data from: ${url}`);
    }
    return url.endsWith(".json")
      ? await response.json()
      : await response.text();
  } catch (error) {
    console.error(`Error fetching data from ${url}:`, error);
    throw error;
  }
}

/**
 * Injects content into a target element by ID.
 * @param {string} elementId - The ID of the element to inject content into.
 * @param {string} content - The HTML content to inject.
 */
function injectContent(elementId, content) {
  const targetElement = document.getElementById(elementId);
  if (!targetElement) {
    throw new Error(`Element with id ${elementId} not found`);
  }
  targetElement.innerHTML = content;
}

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
  const url = `https://raw.githubusercontent.com/PalomeroLab/palomerolab.github.io/main/${filePath}`;

  try {
    const markdownText = await fetchData(url); // Using the fetchData helper
    const htmlContent = marked.parse(markdownText);
    injectContent(elementId, htmlContent); // Using the injectContent helper
    console.log("Markdown injected successfully.");
  } catch (error) {
    console.error("Error loading or converting markdown:", error);
  }
}

/**
 * Fetches the JSON data containing information about lab members from GitHub.
 * @returns {Promise<Object>} A promise that resolves to the people data object.
 * @throws Will throw an error if the fetch fails.
 *
 * @details
 * This function fetches the people data from a GitHub-hosted JSON file containing lab member information.
 */
async function fetchPeopleData() {
  const url =
    "https://raw.githubusercontent.com/PalomeroLab/palomerolab.github.io/main/people.json";
  return fetchData(url); // Using the fetchData helper
}

/**
 * Renders the list of people in the lab from the fetched JSON data.
 * @throws Will log errors if the section element is not found or if rendering issues occur.
 */
async function renderPeopleSection() {
  try {
    const data = await fetchPeopleData();

    const peopleSection = document.getElementById("dynamic-people-section");
    if (!peopleSection) throw new Error("People section not found");

    let content = "";
    Object.entries(data).forEach(([group, members]) => {
      content += `<div class="mb-5">
                    <h3>${group}</h3>
                    <div class="row">`;
      members.forEach((member) => {
        content += `<div class="col-sm-4 mx-0 px-2">
                      <div class="card">
                        <img src="${member.photo}" class="card-img-top" alt="${member.name}" />
                        <div class="card-body">
                          <p class="card-title"><strong>${member.name}</strong></p>
                          <p class="card-text">${member.description}</p>
                        </div>
                      </div>
                    </div>`;
      });
      content += `</div></div>`;
    });

    injectContent("dynamic-people-section", content); // Using the injectContent helper
    console.log("People section rendered.");
  } catch (error) {
    console.error("Error rendering people section:", error);
  }
}

// Add event listeners to execute functions when the DOM is fully loaded
document.addEventListener("DOMContentLoaded", function () {
  console.log("Document loaded, calling functions...");
  injectMarkdownFromUrl("assets/bios/about.md", "about-content");
  injectMarkdownFromUrl("assets/bios/teresa.md", "teresa-bio");
  renderPeopleSection();
});

console.log("scripts.js loaded");
