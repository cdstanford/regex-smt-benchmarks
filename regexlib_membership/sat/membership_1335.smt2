;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]+[a-zA-Z0-9_-]*@([a-zA-Z0-9]+){1}(\.[a-zA-Z0-9]+){1,2}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "vo@8.5.58x6393\u00E4C\u008F\xD\u00AB"
(define-fun Witness1 () String (str.++ "v" (str.++ "o" (str.++ "@" (str.++ "8" (str.++ "." (str.++ "5" (str.++ "." (str.++ "5" (str.++ "8" (str.++ "x" (str.++ "6" (str.++ "3" (str.++ "9" (str.++ "3" (str.++ "\u{e4}" (str.++ "C" (str.++ "\u{8f}" (str.++ "\u{0d}" (str.++ "\u{ab}" ""))))))))))))))))))))
;witness2: "bJp@V.JJ"
(define-fun Witness2 () String (str.++ "b" (str.++ "J" (str.++ "p" (str.++ "@" (str.++ "V" (str.++ "." (str.++ "J" (str.++ "J" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) ((_ re.loop 1 2) (re.++ (re.range "." ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
