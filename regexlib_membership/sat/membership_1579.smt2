;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^p(ost)?[ |\.]*o(ffice)?[ |\.]*(box)?[ 0-9]*[^[a-z ]]*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "post|o.|Q\u00DE\u00A5"
(define-fun Witness1 () String (str.++ "p" (str.++ "o" (str.++ "s" (str.++ "t" (str.++ "|" (str.++ "o" (str.++ "." (str.++ "|" (str.++ "Q" (str.++ "\u{de}" (str.++ "\u{a5}" ""))))))))))))
;witness2: "poffice.\u00E9]]]"
(define-fun Witness2 () String (str.++ "p" (str.++ "o" (str.++ "f" (str.++ "f" (str.++ "i" (str.++ "c" (str.++ "e" (str.++ "." (str.++ "\u{e9}" (str.++ "]" (str.++ "]" (str.++ "]" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "p" "p")(re.++ (re.opt (str.to_re (str.++ "o" (str.++ "s" (str.++ "t" "")))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "." ".") (re.range "|" "|"))))(re.++ (re.range "o" "o")(re.++ (re.opt (str.to_re (str.++ "f" (str.++ "f" (str.++ "i" (str.++ "c" (str.++ "e" "")))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "." ".") (re.range "|" "|"))))(re.++ (re.opt (str.to_re (str.++ "b" (str.++ "o" (str.++ "x" "")))))(re.++ (re.* (re.union (re.range " " " ") (re.range "0" "9")))(re.++ (re.union (re.range "\u{00}" "\u{1f}")(re.union (re.range "!" "Z")(re.union (re.range "\u{5c}" "`") (re.range "{" "\u{ff}")))) (re.* (re.range "]" "]"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
