;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{1,2}[0-9]{1,2}|[A-Z]{3}|[A-Z]{1,2}[0-9][A-Z])( |-)[0-9][A-Z]{2}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ZX0X 6SK\x1A\u00C3\u00D7"
(define-fun Witness1 () String (str.++ "Z" (str.++ "X" (str.++ "0" (str.++ "X" (str.++ " " (str.++ "6" (str.++ "S" (str.++ "K" (str.++ "\u{1a}" (str.++ "\u{c3}" (str.++ "\u{d7}" ""))))))))))))
;witness2: "PBU-2WZ\u00A8\u008F\x1D"
(define-fun Witness2 () String (str.++ "P" (str.++ "B" (str.++ "U" (str.++ "-" (str.++ "2" (str.++ "W" (str.++ "Z" (str.++ "\u{a8}" (str.++ "\u{8f}" (str.++ "\u{1d}" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 1 2) (re.range "A" "Z")) ((_ re.loop 1 2) (re.range "0" "9")))(re.union ((_ re.loop 3 3) (re.range "A" "Z")) (re.++ ((_ re.loop 1 2) (re.range "A" "Z"))(re.++ (re.range "0" "9") (re.range "A" "Z")))))(re.++ (re.union (re.range " " " ") (re.range "-" "-"))(re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.range "A" "Z"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
