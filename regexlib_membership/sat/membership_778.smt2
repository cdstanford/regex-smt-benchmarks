;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9]+)([\._-]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]+)([\._-]?[a-zA-Z0-9]+)*([\.]{1}[a-zA-Z0-9]{2,})+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "u8F.Z8Q@ZH39.F85"
(define-fun Witness1 () String (str.++ "u" (str.++ "8" (str.++ "F" (str.++ "." (str.++ "Z" (str.++ "8" (str.++ "Q" (str.++ "@" (str.++ "Z" (str.++ "H" (str.++ "3" (str.++ "9" (str.++ "." (str.++ "F" (str.++ "8" (str.++ "5" "")))))))))))))))))
;witness2: "6F_90@x04_I.3AA.a9"
(define-fun Witness2 () String (str.++ "6" (str.++ "F" (str.++ "_" (str.++ "9" (str.++ "0" (str.++ "@" (str.++ "x" (str.++ "0" (str.++ "4" (str.++ "_" (str.++ "I" (str.++ "." (str.++ "3" (str.++ "A" (str.++ "A" (str.++ "." (str.++ "a" (str.++ "9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.+ (re.++ (re.range "." ".") (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
