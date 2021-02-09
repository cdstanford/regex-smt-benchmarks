;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\+?\(?\d+\)?(\s|\-|\.)?\d{1,3}(\s|\-|\.)?\d{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "90\xC14835"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "0" (seq.++ "\x0c" (seq.++ "1" (seq.++ "4" (seq.++ "8" (seq.++ "3" (seq.++ "5" "")))))))))
;witness2: "+(82938788"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "(" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.opt (re.range "(" "("))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
