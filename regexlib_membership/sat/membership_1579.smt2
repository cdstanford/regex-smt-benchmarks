;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^p(ost)?[ |\.]*o(ffice)?[ |\.]*(box)?[ 0-9]*[^[a-z ]]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "post|o.|Q\u00DE\u00A5"
(define-fun Witness1 () String (seq.++ "p" (seq.++ "o" (seq.++ "s" (seq.++ "t" (seq.++ "|" (seq.++ "o" (seq.++ "." (seq.++ "|" (seq.++ "Q" (seq.++ "\xde" (seq.++ "\xa5" ""))))))))))))
;witness2: "poffice.\u00E9]]]"
(define-fun Witness2 () String (seq.++ "p" (seq.++ "o" (seq.++ "f" (seq.++ "f" (seq.++ "i" (seq.++ "c" (seq.++ "e" (seq.++ "." (seq.++ "\xe9" (seq.++ "]" (seq.++ "]" (seq.++ "]" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "p" "p")(re.++ (re.opt (str.to_re (seq.++ "o" (seq.++ "s" (seq.++ "t" "")))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "." ".") (re.range "|" "|"))))(re.++ (re.range "o" "o")(re.++ (re.opt (str.to_re (seq.++ "f" (seq.++ "f" (seq.++ "i" (seq.++ "c" (seq.++ "e" "")))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "." ".") (re.range "|" "|"))))(re.++ (re.opt (str.to_re (seq.++ "b" (seq.++ "o" (seq.++ "x" "")))))(re.++ (re.* (re.union (re.range " " " ") (re.range "0" "9")))(re.++ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "Z")(re.union (re.range "\x5c" "`") (re.range "{" "\xff")))) (re.* (re.range "]" "]"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
