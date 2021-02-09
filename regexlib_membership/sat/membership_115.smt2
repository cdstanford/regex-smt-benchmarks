;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-ZÄÖÜ][a-zäöüß]+(([.] )|( )|([-])))+[1-9][0-9]{0,3}[a-z]?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Q\u00E4z 5"
(define-fun Witness1 () String (seq.++ "Q" (seq.++ "\xe4" (seq.++ "z" (seq.++ " " (seq.++ "5" ""))))))
;witness2: "Jq-\u00DC\u00DF. 6"
(define-fun Witness2 () String (seq.++ "J" (seq.++ "q" (seq.++ "-" (seq.++ "\xdc" (seq.++ "\xdf" (seq.++ "." (seq.++ " " (seq.++ "6" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.union (re.range "A" "Z")(re.union (re.range "\xc4" "\xc4")(re.union (re.range "\xd6" "\xd6") (re.range "\xdc" "\xdc"))))(re.++ (re.+ (re.union (re.range "a" "z")(re.union (re.range "\xdf" "\xdf")(re.union (re.range "\xe4" "\xe4")(re.union (re.range "\xf6" "\xf6") (re.range "\xfc" "\xfc")))))) (re.union (str.to_re (seq.++ "." (seq.++ " " "")))(re.union (re.range " " " ") (re.range "-" "-"))))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 3) (re.range "0" "9"))(re.++ (re.opt (re.range "a" "z")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
