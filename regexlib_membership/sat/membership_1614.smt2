;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(((\d*\.?\d*[0-9]+\d*)|([0-9]+\d*\.\d*) )\s*[xX]\s*){2}((\d*\.?\d*[0-9]+\d*)|([0-9]+\d*\.\d*))\s*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "881.9 x\u0085\xC3853. x9 \xA"
(define-fun Witness1 () String (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "." (str.++ "9" (str.++ " " (str.++ "x" (str.++ "\u{85}" (str.++ "\u{0c}" (str.++ "3" (str.++ "8" (str.++ "5" (str.++ "3" (str.++ "." (str.++ " " (str.++ "x" (str.++ "9" (str.++ " " (str.++ "\u{0a}" ""))))))))))))))))))))
;witness2: "67988X\u00A0\u00A07. x00098"
(define-fun Witness2 () String (str.++ "6" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "X" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "7" (str.++ "." (str.++ " " (str.++ "x" (str.++ "0" (str.++ "0" (str.++ "0" (str.++ "9" (str.++ "8" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.++ (re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "0" "9")) (re.* (re.range "0" "9")))))) (re.++ (re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".") (re.* (re.range "0" "9"))))) (re.range " " " ")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.range "X" "X") (re.range "x" "x")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))(re.++ (re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "0" "9")) (re.* (re.range "0" "9")))))) (re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".") (re.* (re.range "0" "9"))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
