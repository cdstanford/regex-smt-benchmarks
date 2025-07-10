;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http[s]?://[a-zA-Z0-9.-/]+
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "H9https://4"
(define-fun Witness1 () String (str.++ "H" (str.++ "9" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "4" ""))))))))))))
;witness2: "\u00A0nhttp://.5"
(define-fun Witness2 () String (str.++ "\u{a0}" (str.++ "n" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "." (str.++ "5" ""))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.++ (re.opt (re.range "s" "s"))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" "")))) (re.+ (re.union (re.range "." "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
