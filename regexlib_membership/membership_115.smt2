;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-ZÄÖÜ][a-zäöüß]+(([.] )|( )|([-])))+[1-9][0-9]{0,3}[a-z]?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Q\u00E4z 5"
(define-fun Witness1 () String (str.++ "Q" (str.++ "\u{e4}" (str.++ "z" (str.++ " " (str.++ "5" ""))))))
;witness2: "Jq-\u00DC\u00DF. 6"
(define-fun Witness2 () String (str.++ "J" (str.++ "q" (str.++ "-" (str.++ "\u{dc}" (str.++ "\u{df}" (str.++ "." (str.++ " " (str.++ "6" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.union (re.range "A" "Z")(re.union (re.range "\u{c4}" "\u{c4}")(re.union (re.range "\u{d6}" "\u{d6}") (re.range "\u{dc}" "\u{dc}"))))(re.++ (re.+ (re.union (re.range "a" "z")(re.union (re.range "\u{df}" "\u{df}")(re.union (re.range "\u{e4}" "\u{e4}")(re.union (re.range "\u{f6}" "\u{f6}") (re.range "\u{fc}" "\u{fc}")))))) (re.union (str.to_re (str.++ "." (str.++ " " "")))(re.union (re.range " " " ") (re.range "-" "-"))))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 3) (re.range "0" "9"))(re.++ (re.opt (re.range "a" "z")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
