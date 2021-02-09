;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http[s]?://[a-zA-Z0-9.-/]+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "H9https://4"
(define-fun Witness1 () String (seq.++ "H" (seq.++ "9" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "4" ""))))))))))))
;witness2: "\u00A0nhttp://.5"
(define-fun Witness2 () String (seq.++ "\xa0" (seq.++ "n" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "." (seq.++ "5" ""))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.++ (re.opt (re.range "s" "s"))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))) (re.+ (re.union (re.range "." "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
