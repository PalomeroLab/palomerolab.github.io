/**
 * @file people.js
 * @brief Fetches and renders a list of lab members using JSON data from GitHub.
 */

/**
 * @function fetchPeopleData
 * @description Fetches the JSON data containing information about lab members from GitHub.
 * @returns {Promise<Object>} A promise that resolves to the people data object.
 *
 * @details
 * This url points to the file contained in the github repository rather than
 * the file in the parent directory. This is because the file in the parent directory
 * is considered unsecure and the fetch request is blocked by the browser, so we
 * need to send an http request to the file in the repository to make the browser happy.
 */
async function fetchPeopleData() {
  const url =
    "https://raw.githubusercontent.com/PalomeroLab/palomerolab.github.io/main/people.json";
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error("Could not fetch people data:", error);
    throw error;
  }
}

/**
 * @function renderPeopleSection
 * @description Renders the list of people in the lab from the fetched JSON data.
 * @throws Will log errors if the section element is not found or if rendering issues occur.
 */
async function renderPeopleSection() {
  console.log("Attempting to render people section...");

  try {
    const data = await fetchPeopleData();
    console.log("JSON data loaded successfully:", data);

    const peopleSection = document.getElementById("dynamic-people-section");
    if (!peopleSection) {
      throw new Error('Element with id "dynamic-people-section" not found');
    }
    console.log("People section found");

    peopleSection.innerHTML = "";

    Object.entries(data).forEach(([group, members]) => {
      console.log(`Processing group: ${group}`);

      const groupSection = document.createElement("div");
      groupSection.className = "mb-5";

      const groupHeader = document.createElement("h3");
      groupHeader.textContent = group;
      groupSection.appendChild(groupHeader);

      const row = document.createElement("div");
      row.className = "row";

      members.forEach((member) => {
        console.log(`Rendering member: ${member.name}`);

        const col = document.createElement("div");
        col.className = "col-sm-4 mx-0 px-2";

        // TODO: templatize the card and store it in a separate file
        col.innerHTML = `
	  <div class="card">
	    <img src="${member.photo}" class="card-img-top" alt="${member.name}" />
	    <div class="card-body">
	      <p class="card-title">
		<strong>${member.name}</strong>
		${member.website ? `<a href="${member.website}" target="_blank" rel="noopener noreferrer"><i class="bi bi-arrow-up-right-circle-fill"></i></a>` : ""}
	      </p>
	      <p class="card-text">${member.description}</p>
	    </div>
	  </div>
	`;

        row.appendChild(col);
      });

      groupSection.appendChild(row);
      peopleSection.appendChild(groupSection);
    });

    console.log("People section rendered successfully");
  } catch (error) {
    console.error("Error rendering people section:", error);
  }
}

// Call the function when the DOM is fully loaded
document.addEventListener("DOMContentLoaded", renderPeopleSection);

console.log("people.js script loaded");
