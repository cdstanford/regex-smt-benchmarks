;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (http://|https://)([a-zA-Z0-9]+\.[a-zA-Z0-9\-]+|[a-zA-Z0-9\-]+)\.[a-zA-Z\.]{2,6}(/[a-zA-Z0-9\.\?=/#%&\+-]+|/|)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://54u..h"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "5" (seq.++ "4" (seq.++ "u" (seq.++ "." (seq.++ "." (seq.++ "h" ""))))))))))))))
;witness2: "https://0.JlR/E-"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "0" (seq.++ "." (seq.++ "J" (seq.++ "l" (seq.++ "R" (seq.++ "/" (seq.++ "E" (seq.++ "-" "")))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))) (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))))(re.++ (re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))) (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 6) (re.union (re.range "." ".")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.union (re.++ (re.range "/" "/") (re.+ (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "+" "+")(re.union (re.range "-" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))(re.union (re.range "/" "/") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
