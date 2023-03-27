;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?:[A-Z](?:('|(?:[a-z]{1,3}))[A-Z])?[a-z]+)|(?:[A-Z]\.))(?:([ -])((?:[A-Z](?:('|(?:[a-z]{1,3}))[A-Z])?[a-z]+)|(?:[A-Z]\.)))?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "VyEf"
(define-fun Witness1 () String (str.++ "V" (str.++ "y" (str.++ "E" (str.++ "f" "")))))
;witness2: "D\'Wz"
(define-fun Witness2 () String (str.++ "D" (str.++ "'" (str.++ "W" (str.++ "z" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "A" "Z")(re.++ (re.opt (re.++ (re.union (re.range "'" "'") ((_ re.loop 1 3) (re.range "a" "z"))) (re.range "A" "Z"))) (re.+ (re.range "a" "z")))) (re.++ (re.range "A" "Z") (re.range "." ".")))(re.++ (re.opt (re.++ (re.union (re.range " " " ") (re.range "-" "-")) (re.union (re.++ (re.range "A" "Z")(re.++ (re.opt (re.++ (re.union (re.range "'" "'") ((_ re.loop 1 3) (re.range "a" "z"))) (re.range "A" "Z"))) (re.+ (re.range "a" "z")))) (re.++ (re.range "A" "Z") (re.range "." "."))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
