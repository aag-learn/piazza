// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import Bridge__NavMenuController from "./bridge/nav_menu_controller"
application.register("bridge--nav-menu", Bridge__NavMenuController)

import ImageUploadController from "./image_upload_controller"
application.register("image-upload", ImageUploadController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import RemoveElementController from "./remove_element_controller"
application.register("remove-element", RemoveElementController)

import TagsController from "./tags_controller"
application.register("tags", TagsController)
