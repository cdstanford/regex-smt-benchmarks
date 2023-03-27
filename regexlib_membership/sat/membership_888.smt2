;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = jar:file:/(([A-Z]:)?/([A-Z 0-9 * ( ) + \- & $ # @ _ . ! ~ /])+)(/[A-Z 0-9 _ ( ) \[ \] - = + _ ~]+\.jar!)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "2.\u00DDjar:file://8/ +.jar!\u00C2"
(define-fun Witness1 () String (str.++ "2" (str.++ "." (str.++ "\u{dd}" (str.++ "j" (str.++ "a" (str.++ "r" (str.++ ":" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "8" (str.++ "/" (str.++ " " (str.++ "+" (str.++ "." (str.++ "j" (str.++ "a" (str.++ "r" (str.++ "!" (str.++ "\u{c2}" "")))))))))))))))))))))))))
;witness2: "\u00A9Jjar:file:/H:/94/~.jar!6\u00B1"
(define-fun Witness2 () String (str.++ "\u{a9}" (str.++ "J" (str.++ "j" (str.++ "a" (str.++ "r" (str.++ ":" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ ":" (str.++ "/" (str.++ "H" (str.++ ":" (str.++ "/" (str.++ "9" (str.++ "4" (str.++ "/" (str.++ "~" (str.++ "." (str.++ "j" (str.++ "a" (str.++ "r" (str.++ "!" (str.++ "6" (str.++ "\u{b1}" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "j" (str.++ "a" (str.++ "r" (str.++ ":" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ ":" (str.++ "/" "")))))))))))(re.++ (re.++ (re.opt (re.++ (re.range "A" "Z") (re.range ":" ":")))(re.++ (re.range "/" "/") (re.+ (re.union (re.range " " "!")(re.union (re.range "#" "$")(re.union (re.range "&" "&")(re.union (re.range "(" "+")(re.union (re.range "-" "9")(re.union (re.range "@" "Z")(re.union (re.range "_" "_") (re.range "~" "~"))))))))))) (re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "+" "+")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "~" "~")))))))))) (str.to_re (str.++ "." (str.++ "j" (str.++ "a" (str.++ "r" (str.++ "!" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
