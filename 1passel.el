;;; 1passel.el --- Retrive password from 1Password  -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Federico Bianchi

;; Author: Federico Bianchi <chiccobia@gmail.com>
;; Homepage: https://github.com/vinid/1passel
;; Created: 17th August 2021

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(require 'json)

(defvar 1passel-session
  "session-token")

(defun 1passel-extract-loop (json-data)
  "Filters the JSON coming from 1password; extracts the name of the account (title) and the id using map"
  (cl-map 'list 'access-values json-data))

(defun access-values (piece)
  "1password returns associative list, so this function is used to extract data"
  (cons (cdr (assoc 'title piece)) (cdr (assoc 'id piece))))

(defun json-or-login ()
  (let* ((json (shell-command-to-string (format "op item list --session=%s --format=json" 1passel-session))))
    (if (string-match-p (regexp-quote "ERROR") json)
	(progn
	  (1passel-login)
	  (json-read-from-string (shell-command-to-string (format "op item list --session=%s" 1passel-session))))
      (json-read-from-string json))))

(defun 1passel-get-password ()
  "Prompts for a list of accounts. Once one is selected, the password is extracted from 1password"
  (interactive)
  
  (let* ((json (json-or-login))
	 (filtered-ids (1passel-extract-loop json)))
    (string-trim
     (kill-new
      (shell-command-to-string
       (format
	"op item get %s --session=%s --fields password"
	(cdr (assoc (completing-read "Search Password: "  (mapcar 'car filtered-ids))
		    filtered-ids)) 1passel-session)))))
  (message "Copied to clipboard"))

(defun 1passel-login ()
  "Creates a new login session for 1password. Stores the session in the variable 1passel-session" 
  (interactive)
  (setq 1passel-session
	(string-trim
	 (shell-command-to-string   
	  "gpg --quiet --for-your-eyes-only --no-tty --decrypt ~/.passwords/1pass.gpg | op signin --raw"))))

(provide '1passel)
