(require 'json)

(defvar 1passel-session
  "session-token")

(defun 1passel-extract-loop (json-data)
  "Filters the JSON coming from 1password; extracts the name of the account (title) and the UUID"  
  (cl-loop for x in json-data
         collect (cons (gethash "title" (gethash "overview" x)) (gethash "uuid" x))))

(defun 1passel-get-password ()
  "Prompts for a list of accounts. Once one is selected, the password is extracted from 1password"
  (interactive)
  (let* ((json-object-type 'hash-table)
	 (json-array-type 'list)
	 (json-key-type 'string)
	 (json (json-read-from-string (shell-command-to-string (format "op list items --session=%s" 1passel-session))))
	 (filtered-ids (1passel-extract-loop json)))
    (string-trim
     (kill-new
      (shell-command-to-string
       (format
	"op get item %s --session=%s --fields password"
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
