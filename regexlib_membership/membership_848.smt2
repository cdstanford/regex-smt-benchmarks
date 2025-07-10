;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (http://|)(www\.)?([^\.]+)\.(\w{2}|(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://www.\u00EDn.coop"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "\u{ed}" (str.++ "n" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "o" (str.++ "p" "")))))))))))))))))))
;witness2: "\x9\u00BEe.info"
(define-fun Witness2 () String (str.++ "\u{09}" (str.++ "\u{be}" (str.++ "e" (str.++ "." (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" "")))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))) (str.to_re ""))(re.++ (re.opt (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." ""))))))(re.++ (re.+ (re.union (re.range "\u{00}" "-") (re.range "/" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "m" ""))))(re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "t" ""))))(re.union (str.to_re (str.++ "o" (str.++ "r" (str.++ "g" ""))))(re.union (str.to_re (str.++ "e" (str.++ "d" (str.++ "u" ""))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "t" ""))))(re.union (str.to_re (str.++ "m" (str.++ "i" (str.++ "l" ""))))(re.union (str.to_re (str.++ "g" (str.++ "o" (str.++ "v" ""))))(re.union (str.to_re (str.++ "a" (str.++ "r" (str.++ "p" (str.++ "a" "")))))(re.union (str.to_re (str.++ "b" (str.++ "i" (str.++ "z" ""))))(re.union (str.to_re (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" "")))))(re.union (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" "")))))(re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "o" (str.++ "p" "")))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" "")))))(re.union (str.to_re (str.++ "p" (str.++ "r" (str.++ "o" "")))) (str.to_re (str.++ "m" (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "u" (str.++ "m" "")))))))))))))))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
