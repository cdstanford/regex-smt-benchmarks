;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^~/[0-9a-zA-Z_][0-9a-zA-Z/_-]*\.[0-9a-zA-Z_-]+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "~/8O.-"
(define-fun Witness1 () String (str.++ "~" (str.++ "/" (str.++ "8" (str.++ "O" (str.++ "." (str.++ "-" "")))))))
;witness2: "~/4.-"
(define-fun Witness2 () String (str.++ "~" (str.++ "/" (str.++ "4" (str.++ "." (str.++ "-" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "~" (str.++ "/" "")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
