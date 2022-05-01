[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GPL3 License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
[![Ask Me Anything][ask-me-anything]][personal-page]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/not-existing-organization/terraform_module_security_group_checker">
    <img src="https://github.com/not-existing-organization/terraform_module_security_group_checker/raw/master/.assets/terraform-logo.png" alt="Terraform Logo" width="80" height="80">

  </a>

<h3 align="center">terraform_module_security_group_checker</h3>

  <p align="center">
    Terraform & python pet project to monitor & store AWS security group IDs in a DynamoDB table that fall into certain criteria
    <br />
    <a href="https://github.com/not-existing-organization/terraform_module_security_group_checker/blob/master/README.md"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/not-existing-organization/terraform_module_security_group_checker">View Demo</a>
    ·
    <a href="https://github.com/not-existing-organization/terraform_module_security_group_checker/issues/new?labels=i%3A+bug&template=1-bug-report.md">Report Bug</a>
    ·
    <a href="https://github.com/not-existing-organization/terraform_module_security_group_checker/issues/new?labels=i%3A+enhancement&template=2-feature-request.md">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->

## Table of Contents

- [Table of Contents](#table-of-contents)
- [About The Project](#about-the-project)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgements](#acknowledgements)

<!-- ABOUT THE PROJECT -->

## About The Project

This is a simple project that involves a python script that scans the Ec2 API in search of a certain criteria (currently is fixed to a SG (Security Group) rule matching *0.0.0.0/0*) and then store that SG id in a DynamoDB table. If that criteria is "remediated" the script will delete that SG id from the table, that way you can keep a live record of SG ids you wish to keep monitored. Everything is glued together with terraform which will zip the python script and deploy it to the lambda function.

I made this project as part of my learning process since i did not have that much practice with the DynamoDB service, but also i wanted to glue everything with python and terraform and have some fun along the way.

<!--
There are many great README templates available on GitHub, however, I didn't find one that really suit my needs so I created this enhanced one. I want to create a README template so amazing that it'll be the last one you ever need.

Here's why:

- Your time should be focused on creating something amazing. A project that solves a problem and helps others
- You shouldn't be doing the same tasks over and over like creating a README from scratch
- You should element DRY principles to the rest of your life :smile:

Of course, no one template will serve all projects since your needs may be different. So I'll be adding more in the near future. You may also suggest changes by forking this repo and creating a pull request or opening an issue.

A list of commonly used resources that I find helpful are listed in the acknowledgements.
-->

### Built With

Terraform

Python

AWS services (DynamoDB, IAM, Lambda, Cloudwatch)

<!--
This section should list any major frameworks that you built your project using. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

- [Bootstrap](https://getbootstrap.com)
- [JQuery](https://jquery.com)
- [Laravel](https://laravel.com)
-->

---

<!-- GETTING STARTED -->

## Getting Started


<!--
This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.
-->

### Prerequisites

Terraform: Deployed with version 1.0.6

Python: AWS lambda runtime with version 3.8

<!--

This is an example of how to list things you need to use the software and how to install them.

- npm

```sh
npm install npm@latest -g
```
-->

### Installation

Install Terraform

https://learn.hashicorp.com/tutorials/terraform/install-cli

Install AWS cli and configure your AWS credentials (you should have a AWS account already)

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html



<!--
1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo

```sh
git clone https://github.com/your_username_/Project-Name.git
```

3. Install NPM packages

```sh
npm install
```

4. Enter your API in `config.js`

```JS
const API_KEY = 'ENTER YOUR API';
```
-->

---

<!-- USAGE EXAMPLES -->

## Usage

The whole solution will be deployed via terraform

```
terraform init
terraform plan
terraform apply 
```

There's a locals block in the *main.tf* file to modify a couple of fields that are consumed by several parts of the project. The *table name*, *attribue name* for that table and *schedule expression* that defines the rate of how frequent the Cloudwatch event rule executes the lambda function.

<!--
Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_
-->

---

<!-- ROADMAP -->

## Roadmap

See the [open issues](https://github.com/not-existing-organization/terraform_module_security_group_checker/raw/main/issues) for a list of proposed features (and known issues).

---

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

<!-- LICENSE -->

## License

Distributed under the GPL-3.0 License. See `LICENSE` for more information.

<!-- CONTACT -->

## Contact

Santiago - elfmg1@gmail.com

---

<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

- [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
- [Img Shields](https://shields.io)
- [Choose an Open Source License](https://choosealicense.com)
- [GitHub Pages](https://pages.github.com)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/not-existing-organization/terraform_module_security_group_checker.svg?style=for-the-badge
[contributors-url]: https://github.com/not-existing-organization/terraform_module_security_group_checker/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/not-existing-organization/terraform_module_security_group_checker.svg?style=for-the-badge
[forks-url]: https://github.com/not-existing-organization/terraform_module_security_group_checker/network/members
[stars-shield]: https://img.shields.io/github/stars/not-existing-organization/terraform_module_security_group_checker.svg?style=for-the-badge
[stars-url]: https://github.com/not-existing-organization/terraform_module_security_group_checker/stargazers
[issues-shield]: https://img.shields.io/github/issues/not-existing-organization/terraform_module_security_group_checker.svg?style=for-the-badge
[issues-url]: https://github.com/not-existing-organization/terraform_module_security_group_checker/issues
[license-shield]: https://img.shields.io/github/license/not-existing-organization/terraform_module_security_group_checker?style=for-the-badge
[license-url]: https://github.com/not-existing-organization/terraform_module_security_group_checker/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/santiago-delcampo/
[product-screenshot]: .assets/screenshot.png
[ask-me-anything]: https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg?style=for-the-badge
[personal-page]: https://github.com/not-existing-organization
