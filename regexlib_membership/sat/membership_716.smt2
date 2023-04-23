;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9]+[a-zA-Z0-9._%-]*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,4})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "N9u@8.DP"
(define-fun Witness1 () String (str.++ "N" (str.++ "9" (str.++ "u" (str.++ "@" (str.++ "8" (str.++ "." (str.++ "D" (str.++ "P" "")))))))))
;witness2: "x9_@M.-4-.9.nZ"
(define-fun Witness2 () String (str.++ "x" (str.++ "9" (str.++ "_" (str.++ "@" (str.++ "M" (str.++ "." (str.++ "-" (str.++ "4" (str.++ "-" (str.++ "." (str.++ "9" (str.++ "." (str.++ "n" (str.++ "Z" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.union (re.range "%" "%")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." "."))) ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
