;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [du]{2}|[gu]{2}|[tu]{2}|[ds]{2}|[gs]{2}|[da]{2}|[ga]{2}|[ta]{2}|[dq]{2}|[gq]{2}|[tq]{2}|[DU]{2}|[GU]{2}|[TU]{2}|[DS]{2}|[GS]{2}|[DA]{2}|[GA]{2}|[TA]{2}|[DQ]{2}|[GQ]{2}|[TQ]{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00DC\u00B8GG\u00A5"
(define-fun Witness1 () String (seq.++ "\xdc" (seq.++ "\xb8" (seq.++ "G" (seq.++ "G" (seq.++ "\xa5" ""))))))
;witness2: "SSV\u0093?"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "S" (seq.++ "V" (seq.++ "\x93" (seq.++ "?" ""))))))

(assert (= regexA (re.union ((_ re.loop 2 2) (re.union (re.range "d" "d") (re.range "u" "u")))(re.union ((_ re.loop 2 2) (re.union (re.range "g" "g") (re.range "u" "u")))(re.union ((_ re.loop 2 2) (re.range "t" "u"))(re.union ((_ re.loop 2 2) (re.union (re.range "d" "d") (re.range "s" "s")))(re.union ((_ re.loop 2 2) (re.union (re.range "g" "g") (re.range "s" "s")))(re.union ((_ re.loop 2 2) (re.union (re.range "a" "a") (re.range "d" "d")))(re.union ((_ re.loop 2 2) (re.union (re.range "a" "a") (re.range "g" "g")))(re.union ((_ re.loop 2 2) (re.union (re.range "a" "a") (re.range "t" "t")))(re.union ((_ re.loop 2 2) (re.union (re.range "d" "d") (re.range "q" "q")))(re.union ((_ re.loop 2 2) (re.union (re.range "g" "g") (re.range "q" "q")))(re.union ((_ re.loop 2 2) (re.union (re.range "q" "q") (re.range "t" "t")))(re.union ((_ re.loop 2 2) (re.union (re.range "D" "D") (re.range "U" "U")))(re.union ((_ re.loop 2 2) (re.union (re.range "G" "G") (re.range "U" "U")))(re.union ((_ re.loop 2 2) (re.range "T" "U"))(re.union ((_ re.loop 2 2) (re.union (re.range "D" "D") (re.range "S" "S")))(re.union ((_ re.loop 2 2) (re.union (re.range "G" "G") (re.range "S" "S")))(re.union ((_ re.loop 2 2) (re.union (re.range "A" "A") (re.range "D" "D")))(re.union ((_ re.loop 2 2) (re.union (re.range "A" "A") (re.range "G" "G")))(re.union ((_ re.loop 2 2) (re.union (re.range "A" "A") (re.range "T" "T")))(re.union ((_ re.loop 2 2) (re.union (re.range "D" "D") (re.range "Q" "Q")))(re.union ((_ re.loop 2 2) (re.union (re.range "G" "G") (re.range "Q" "Q"))) ((_ re.loop 2 2) (re.union (re.range "Q" "Q") (re.range "T" "T"))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
