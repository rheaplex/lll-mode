;;; lll-mode.el - Ethereum Low Level Language major mode
;;
;; Copyright (C) 2014 Rob Myers <rob@robmyers.org>
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Works well with electric-pair mode from Emacs 24.1
;; Include this in a hook: (electric-pair-mode 1)

;;; Installation
;;
;; To install, add this file to your Emacs load path.
;; You can then load it using M-x lll-mode
;; Alternatively you can have Emacs load it automatically for files with
;; a .strike extension by adding the following to your .emacs file:
;; 
;;    (require 'lll-mode)
;;    (add-to-list 'auto-mode-alist '("\\.lll$" . lll-mode))

;; FIXME: case sensitive?
;; FIXME: all opcodes

(defconst lll-font-lock-keywords
      '(("\\<\\(call\\|calldatacopy\\|calldataload\\|codecopy\\|create\\|for\\|if\\|mload\\|mstore\\|mstore8\\|return\\|sha3\\|sload\\|sstore\\|stop\\|suicide\\|swap\\|unless\\|when\\)\\>"
         . font-lock-keyword-face)
        ("\\<\\(asm\\|def\\|lit\\|lll\\|raw\\|seq\\)\\>"
         . font-lock-builtin-face)
        ("\\<\\(address\\|balance\\|caller\\|calldatasize\\|callvalue\\|codesize\\|coinbase\\|difficulty\\|gas\\|gaslimit\\|gasprice\\|memsize\\|number\\|origin\\|prevhash\\|timestamp\\)\\>"
         . font-lock-constant-face))
      "Highlighting for lll major mode.")

(defvar lll-syntax-table
  (let ((st (make-syntax-table lisp-mode-syntax-table)))
    (modify-syntax-entry ?\[ "(]  " st)
    (modify-syntax-entry ?\] ")[  " st)
    (modify-syntax-entry ?\{ "(}  " st)
    (modify-syntax-entry ?\} "){  " st)
    st)
  "Syntax table for lll major mode.")

(put 'asm 'lisp-indent-function 0)
(put 'def 'lisp-indent-function 0)
(put 'lit 'lisp-indent-function 0)
(put 'lll 'lisp-indent-function 0)
(put 'raw 'lisp-indent-function 0)
(put 'return 'lisp-indent-function 'defun)
(put 'seq 'lisp-indent-function 0)
  
;;;###autoload
(define-derived-mode lll-mode lisp-mode "lll"
  "Major mode for editing Ethereum Low Level Language programming language files.
\\{lll-mode-map}"
  :syntax-table lll-syntax-table
  (set (make-local-variable 'font-lock-defaults)
       '(lll-font-lock-keywords))
  (set (make-local-variable 'electric-pair-pairs)
       '((?\" . ?\")
         (?\[ . ?\])
         (?\{ . ?\}))))

(provide 'lll-mode)
