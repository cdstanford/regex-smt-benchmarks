;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(ftp|https?):\/\/([^:]+:[^@]*@)?([a-zA-Z0-9][-_a-zA-Z0-9]*\.)*([a-zA-Z0-9][-_a-zA-Z0-9]*){1}(:[0-9]+)?\/?(((\/|\[|\]|-|~|_|\.|:|[a-zA-Z0-9]|%[0-9a-fA-F]{2})*)\?((\/|\[|\]|-|~|_|\.|,|:|=||\{|\}|[a-zA-Z0-9]|%[0-9a-fA-F]{2})*\&?)*)?(#([-_.a-zA-Z0-9]|%[a-fA-F0-9]{2})*)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "https://3.XZ.v%13?"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "3" (seq.++ "." (seq.++ "X" (seq.++ "Z" (seq.++ "." (seq.++ "v" (seq.++ "%" (seq.++ "1" (seq.++ "3" (seq.++ "?" "")))))))))))))))))))
;witness2: "http://\u00A4\u00D4:@f/"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xa4" (seq.++ "\xd4" (seq.++ ":" (seq.++ "@" (seq.++ "f" (seq.++ "/" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))) (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" ""))))) (re.opt (re.range "s" "s"))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "\x00" "9") (re.range ";" "\xff")))(re.++ (re.range ":" ":")(re.++ (re.* (re.union (re.range "\x00" "?") (re.range "A" "\xff"))) (re.range "@" "@")))))(re.++ (re.* (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (re.range "." "."))))(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.opt (re.++ (re.* (re.union (re.union (re.range "-" ":")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.++ (re.range "?" "?") (re.* (re.++ (re.* (re.union (re.union (re.range "," "/")(re.union (re.range ":" ":")(re.union (re.range "=" "=")(re.union (re.range "[" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "~" "~")))))))(re.union (str.to_re "")(re.union (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "{") (re.range "}" "}")))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))))) (re.opt (re.range "&" "&")))))))(re.++ (re.opt (re.++ (re.range "#" "#") (re.* (re.union (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
