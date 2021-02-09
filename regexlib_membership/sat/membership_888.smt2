;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = jar:file:/(([A-Z]:)?/([A-Z 0-9 * ( ) + \- & $ # @ _ . ! ~ /])+)(/[A-Z 0-9 _ ( ) \[ \] - = + _ ~]+\.jar!)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2.\u00DDjar:file://8/ +.jar!\u00C2"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "." (seq.++ "\xdd" (seq.++ "j" (seq.++ "a" (seq.++ "r" (seq.++ ":" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "8" (seq.++ "/" (seq.++ " " (seq.++ "+" (seq.++ "." (seq.++ "j" (seq.++ "a" (seq.++ "r" (seq.++ "!" (seq.++ "\xc2" "")))))))))))))))))))))))))
;witness2: "\u00A9Jjar:file:/H:/94/~.jar!6\u00B1"
(define-fun Witness2 () String (seq.++ "\xa9" (seq.++ "J" (seq.++ "j" (seq.++ "a" (seq.++ "r" (seq.++ ":" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "H" (seq.++ ":" (seq.++ "/" (seq.++ "9" (seq.++ "4" (seq.++ "/" (seq.++ "~" (seq.++ "." (seq.++ "j" (seq.++ "a" (seq.++ "r" (seq.++ "!" (seq.++ "6" (seq.++ "\xb1" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "j" (seq.++ "a" (seq.++ "r" (seq.++ ":" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" "")))))))))))(re.++ (re.++ (re.opt (re.++ (re.range "A" "Z") (re.range ":" ":")))(re.++ (re.range "/" "/") (re.+ (re.union (re.range " " "!")(re.union (re.range "#" "$")(re.union (re.range "&" "&")(re.union (re.range "(" "+")(re.union (re.range "-" "9")(re.union (re.range "@" "Z")(re.union (re.range "_" "_") (re.range "~" "~"))))))))))) (re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "+" "+")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "~" "~")))))))))) (str.to_re (seq.++ "." (seq.++ "j" (seq.++ "a" (seq.++ "r" (seq.++ "!" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
