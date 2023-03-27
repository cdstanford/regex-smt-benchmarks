;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((?<Owner>\[?[\w\d]+\]?)\.{1})?(?<Column>\[?[\w\d]+\]?)(\s*(([><=]{1,2})|(Not|In\(|Between){1,2})\s*)(?<Value>[\w\d\']+)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AA.[9\u0085BetweenNotR\'\u00E5\'\u00AAx\u00AA"
(define-fun Witness1 () String (str.++ "\u{aa}" (str.++ "." (str.++ "[" (str.++ "9" (str.++ "\u{85}" (str.++ "B" (str.++ "e" (str.++ "t" (str.++ "w" (str.++ "e" (str.++ "e" (str.++ "n" (str.++ "N" (str.++ "o" (str.++ "t" (str.++ "R" (str.++ "'" (str.++ "\u{e5}" (str.++ "'" (str.++ "\u{aa}" (str.++ "x" (str.++ "\u{aa}" "")))))))))))))))))))))))
;witness2: "\u00C1I[\u00AA]=x\u00AA\u00F0"
(define-fun Witness2 () String (str.++ "\u{c1}" (str.++ "I" (str.++ "[" (str.++ "\u{aa}" (str.++ "]" (str.++ "=" (str.++ "x" (str.++ "\u{aa}" (str.++ "\u{f0}" ""))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "]" "]")))) (re.range "." ".")))(re.++ (re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "]" "]"))))(re.++ (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union ((_ re.loop 1 2) (re.range "<" ">")) ((_ re.loop 1 2) (re.union (str.to_re (str.++ "N" (str.++ "o" (str.++ "t" ""))))(re.union (str.to_re (str.++ "I" (str.++ "n" (str.++ "(" "")))) (str.to_re (str.++ "B" (str.++ "e" (str.++ "t" (str.++ "w" (str.++ "e" (str.++ "e" (str.++ "n" "")))))))))))) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (re.+ (re.union (re.range "'" "'")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
