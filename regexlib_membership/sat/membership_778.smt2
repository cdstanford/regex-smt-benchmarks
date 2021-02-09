;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9]+)([\._-]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]+)([\._-]?[a-zA-Z0-9]+)*([\.]{1}[a-zA-Z0-9]{2,})+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "u8F.Z8Q@ZH39.F85"
(define-fun Witness1 () String (seq.++ "u" (seq.++ "8" (seq.++ "F" (seq.++ "." (seq.++ "Z" (seq.++ "8" (seq.++ "Q" (seq.++ "@" (seq.++ "Z" (seq.++ "H" (seq.++ "3" (seq.++ "9" (seq.++ "." (seq.++ "F" (seq.++ "8" (seq.++ "5" "")))))))))))))))))
;witness2: "6F_90@x04_I.3AA.a9"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "F" (seq.++ "_" (seq.++ "9" (seq.++ "0" (seq.++ "@" (seq.++ "x" (seq.++ "0" (seq.++ "4" (seq.++ "_" (seq.++ "I" (seq.++ "." (seq.++ "3" (seq.++ "A" (seq.++ "A" (seq.++ "." (seq.++ "a" (seq.++ "9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.+ (re.++ (re.range "." ".") (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
