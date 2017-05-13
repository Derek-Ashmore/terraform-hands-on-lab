# Terraform Hands On Lab

This project is a hands-on lab that provides an introduction to Terraform using
the following:

* Amazon Web Services (AWS)
* Docker
* Text editor of your choice

## Setting up for the Hands-On Lab

### Download and Install Terraform
Terraform is a "Unzip and Go" install -- nothing more complicated than that. Any platform
that can run Terraform will work for this lab.
> 1. [Terraform download](https://www.terraform.io/downloads.html)

> 2. Unzip Terraform into a directory of your choice. I use something like: ```C:\Software\Terraform```

> 3. Put the Terraform subdirectory in your PATH

> 4. Verify your installation by executing command ```terraform -v``` from the command line.

You should see something like this:
```
C:\>terraform -v
Terraform v0.9.5
```

### Sign-up for an AWS Account
Every effort is made in this lab to use free-tier resources. That said, this lab will
cost something -- typically less than one dollar.  A credit card may be required.
> [AWS Web Services Console](https://aws.amazon.com/)

### Download this Project
> This project is on my [Github](https://github.com/Derek-Ashmore/terraform-hands-on-lab)

> Clone or download/unzip this project

![Lab Download Screenshot](lab-download-screenshot.jpg?raw=true)

<kdb><img class="centered" src="{% static 'lab-download-screenshot.jpg'  %}" width="500" height="500" /></kdb>
