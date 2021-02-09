;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((?<Owner>\[?[\w\d]+\]?)\.{1})?(?<Column>\[?[\w\d]+\]?)(\s*(([><=]{1,2})|(Not|In\(|Between){1,2})\s*)(?<Value>[\w\d\']+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AA.[9\u0085BetweenNotR\'\u00E5\'\u00AAx\u00AA"
(define-fun Witness1 () String (seq.++ "\xaa" (seq.++ "." (seq.++ "[" (seq.++ "9" (seq.++ "\x85" (seq.++ "B" (seq.++ "e" (seq.++ "t" (seq.++ "w" (seq.++ "e" (seq.++ "e" (seq.++ "n" (seq.++ "N" (seq.++ "o" (seq.++ "t" (seq.++ "R" (seq.++ "'" (seq.++ "\xe5" (seq.++ "'" (seq.++ "\xaa" (seq.++ "x" (seq.++ "\xaa" "")))))))))))))))))))))))
;witness2: "\u00C1I[\u00AA]=x\u00AA\u00F0"
(define-fun Witness2 () String (seq.++ "\xc1" (seq.++ "I" (seq.++ "[" (seq.++ "\xaa" (seq.++ "]" (seq.++ "=" (seq.++ "x" (seq.++ "\xaa" (seq.++ "\xf0" ""))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.opt (re.range "]" "]")))) (re.range "." ".")))(re.++ (re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.opt (re.range "]" "]"))))(re.++ (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union ((_ re.loop 1 2) (re.range "<" ">")) ((_ re.loop 1 2) (re.union (str.to_re (seq.++ "N" (seq.++ "o" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "I" (seq.++ "n" (seq.++ "(" "")))) (str.to_re (seq.++ "B" (seq.++ "e" (seq.++ "t" (seq.++ "w" (seq.++ "e" (seq.++ "e" (seq.++ "n" "")))))))))))) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (re.+ (re.union (re.range "'" "'")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
